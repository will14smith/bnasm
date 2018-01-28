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
	mov $0, %rax
	ret

.data

_future: .asciz "Future"
