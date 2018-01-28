.global expires_in

// Note: this is a very simple date comparison
// It doesn't take leap years into account
expires_in:
	// rdi = date_t* base
	// rsi = date_t* maturity
	// rdx = int32_t range

	// rdx = base->years + range
	add (%rdi), %rdx

	// maturity->year > rdx => false
	// maturity->year < rdx => true
	cmp %rdx, (%rsi)
	jg _expires_in_false
	jl _expires_in_true

        // maturity->month > base->month => false
        // maturity->month < base->month => true
	mov 4(%rdi), %rax
	mov 4(%rsi), %rcx
	cmp %rcx, %rax
	jg _expires_in_false
        jl _expires_in_true

	// maturity->day > base->day => false
        // else => true
        mov 5(%rdi), %rax
        mov 5(%rsi), %rcx
        cmp %rcx, %rax
        jg _expires_in_false

_expires_in_true:
        mov $1, %eax
        ret

_expires_in_false:
        mov $0, %eax
        ret
