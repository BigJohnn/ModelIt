//
// SPDX-License-Identifier: BSD-3-Clause
// Copyright Contributors to the OpenEXR Project.
//

//-----------------------------------------------------------------------------
//
//	Routines that generate pseudo-random numbers compatible
//	with the standard erand48(), nrand48(), etc. functions.
//
//-----------------------------------------------------------------------------

#include "ImathRandom.h"
#include <cstdint>

IMATH_INTERNAL_NAMESPACE_SOURCE_ENTER
namespace
{

//
// Static state used by Imath::drand48(), Imath::lrand48() and Imath::srand48()
//

unsigned short staticState[3] = { 0, 0, 0 };

void
rand48Next (unsigned short state[3])
{
    //
    // drand48() and friends are all based on a linear congruential
    // sequence,
    //
    //   x[n+1] = (a * x[n] + c) % m,
    //
    // where a and c are as specified below, and m == (1 << 48)
    //

    static const uint64_t a = uint64_t (0x5deece66dLL);
    static const uint64_t c = uint64_t (0xbLL);

    //
    // Assemble the 48-bit value x[n] from the
    // three 16-bit values stored in state.
    //

    // clang-format off
    uint64_t x = (uint64_t (state[2]) << 32) |
	      (uint64_t (state[1]) << 16) |
	       uint64_t (state[0]);
    // clang-format on

    //
    // Compute x[n+1], except for the "modulo m" part.
    //

    x = a * x + c;

    //
    // Disassemble the 48 least significant bits of x[n+1] into
    // three 16-bit values.  Discard the 16 most significant bits;
    // this takes care of the "modulo m" operation.
    //
    // We assume that sizeof (unsigned short) == 2.
    //

    state[2] = (unsigned short) (x >> 32);
    state[1] = (unsigned short) (x >> 16);
    state[0] = (unsigned short) (x);
}

} // namespace

///
/// Generate double-precision floating-point values between 0.0 and 1.0:
///
/// The exponent is set to 0x3ff, which indicates a value greater
/// than or equal to 1.0, and less than 2.0.  The 48 most significant
/// bits of the significand (mantissa) are filled with pseudo-random
/// bits generated by rand48Next().  The remaining 4 bits are a copy
/// of the 4 most significant bits of the significand.  This results
/// in bit patterns between 0x3ff0000000000000 and 0x3fffffffffffffff,
/// which correspond to uniformly distributed floating-point values
/// between 1.0 and 1.99999999999999978.  Subtracting 1.0 from those
/// values produces numbers between 0.0 and 0.99999999999999978, that
/// is, between 0.0 and 1.0-DBL_EPSILON.
double
erand48 (unsigned short state[3])
{
    rand48Next (state);

    union
    {
        double d;
        uint64_t i;
    } u;

    // clang-format off
    u.i = (uint64_t (0x3ff)    << 52) |	// sign and exponent
	  (uint64_t (state[2]) << 36) |	// significand
	  (uint64_t (state[1]) << 20) |
	  (uint64_t (state[0]) <<  4) |
	  (uint64_t (state[2]) >> 12);
    // clang-format on

    return u.d - 1;
}

/// Return erand48()
double
drand48()
{
    return IMATH_INTERNAL_NAMESPACE::erand48 (staticState);
}

/// Generate uniformly distributed integers between 0 and 0x7fffffff.
long int
nrand48 (unsigned short state[3])
{
    rand48Next (state);

    // clang-format off
    return ((long int) (state[2]) << 15) |
	   ((long int) (state[1]) >>  1);
    // clang-format on
}

/// Return nrand48()
long int
lrand48()
{
    return IMATH_INTERNAL_NAMESPACE::nrand48 (staticState);
}

void
srand48 (long int seed)
{
    staticState[2] = (unsigned short) (seed >> 16);
    staticState[1] = (unsigned short) (seed);
    staticState[0] = 0x330e;
}

float
Rand32::nextf()
{
    //
    // Generate single-precision floating-point values between 0.0 and 1.0:
    //
    // The exponent is set to 0x7f, which indicates a value greater than
    // or equal to 1.0, and less than 2.0.  The 23 bits of the significand
    // (mantissa) are filled with pseudo-random bits generated by
    // Rand32::next().  This results in in bit patterns between 0x3f800000
    // and 0x3fffffff, which correspond to uniformly distributed floating-
    // point values between 1.0 and 1.99999988.  Subtracting 1.0 from
    // those values produces numbers between 0.0 and 0.99999988, that is,
    // between 0.0 and 1.0-FLT_EPSILON.
    //

    next();

    union
    {
        float f;
        unsigned int i;
    } u;

    u.i = 0x3f800000 | (_state & 0x7fffff);
    return u.f - 1;
}

IMATH_INTERNAL_NAMESPACE_SOURCE_EXIT
