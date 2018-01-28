.global get_bucket
.global add_to_bucket

get_bucket:
	// rdi = date_t* data_date
	// rsi = asset_t* asset
	push %r12
	push %r13

        mov %rdi, %r12
        mov %rsi, %r13

	// strcmp("Future", asset->asset_class) != 0 => -1
	mov $_future, %rdi
	mov 8(%r13), %rsi
	call strcmp

	cmp $0, %rax
	je _is_future

	mov $-1, %rax
	jmp _get_bucket_return

	_is_future:
	// expires_in(data_date, &asset->maturity_date, 2) => 1
	mov %r12, %rdi
	lea 20(%r13), %rsi
	mov $2, %rdx
	call expires_in

	cmp $0, %rax
	je _bucket_2

	mov $1, %rax
	jmp _get_bucket_return

	_bucket_2:
	// expires_in(data_date, &asset->maturity_date, 7) => 2
        mov %r12, %rdi
        lea 20(%r13), %rsi
        mov $7, %rdx
        call expires_in

        cmp $0, %rax
        je _bucket_3

        mov $2, %rax
	jmp _get_bucket_return

	_bucket_3:
	// expires_in(data_date, &asset->maturity_date, 15) => 3
        mov %r12, %rdi
        lea 20(%r13), %rsi
        mov $15, %rdx
        call expires_in

        cmp $0, %rax
        je _bucket_4

        mov $3, %rax
        pop %r13
        pop %r12
        ret

	_bucket_4:
	// else => 4

	mov $4, %rax
	_get_bucket_return:
        pop %r13
        pop %r12
	ret

add_to_bucket:
	// rdi = date_t* data_date
        // rsi = asset_t* asset
	// rdx = bucket_t buckets[4]

	push %r12
	push %r13

	mov %rsi, %r12
	mov %rdx, %r13

	// rax = get_bucket(data_date, asset)
	call get_bucket

	// rax <= 0 => return
	cmp $0, %rax
	jle _add_to_bucket_return

	// buckets[rax - 1].market_value += asset->market_value
	sub $1, %rax
	mov 16(%r12), %edi
	add %edi, 4(%r13, %rax, 8)

	_add_to_bucket_return:
	pop %r13
        pop %r12
	ret

.data

_future: .asciz "Future"
