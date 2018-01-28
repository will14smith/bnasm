.global get_bucket

get_bucket:
	// rdi = date_t* data_date
	// rsi = asset_t* asset

        mov %rdi, %r12
        mov %rsi, %r13

	// strcmp("Future", asset->asset_class) != 0 => -1
	mov $_future, %rdi
	mov 8(%r13), %rsi
	call strcmp

	cmp $0, %rax
	je _is_future

	mov $-1, %rax
	ret

_is_future:
	// expires_in(data_date, &asset->maturity_date, 2) => 1
	mov %r12, %rdi
	lea 20(%r13), %rsi
	mov $2, %rdx
	call expires_in

	cmp $0, %rax
	je _bucket_2

	mov $1, %rax
        ret

_bucket_2:

	// expires_in(data_date, &asset->maturity_date, 7) => 2
	// expires_in(data_date, &asset->maturity_date, 15) => 3
	// else => 4

	mov $4, %rax
	ret

.data

_future: .asciz "Future"
