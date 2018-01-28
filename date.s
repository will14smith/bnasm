.global expires_in

// Note: this is a very simple date comparison
// It doesn't take leap years into account
expires_in:
	// rdi = date_t* base
	// rsi = date_t* maturity
	// rdx = int32_t range

	// rdx = base->years + range
	add (%rdi), %edx

	// maturity->year > rdx => false
	// maturity->year < rdx => true
	cmp %edx, (%rsi)
	jg _expires_in_false
	jl _expires_in_true

        // maturity->month > base->month => false
        // maturity->month < base->month => true
	mov 4(%rdi), %al
	mov 4(%rsi), %cl
	cmp %al, %cl
	jg _expires_in_false
        jl _expires_in_true

	// maturity->day > base->day => false
        // else => true
        mov 5(%rdi), %al
        mov 5(%rsi), %cl
        cmp %al, %cl
        jg _expires_in_false

_expires_in_true:
        mov $1, %rax
        ret

_expires_in_false:
        mov $0, %rax
        ret
