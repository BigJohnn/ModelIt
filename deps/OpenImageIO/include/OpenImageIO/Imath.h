// Copyright Contributors to the OpenImageIO project.
// SPDX-License-Identifier: Apache-2.0
// https://github.com/OpenImageIO/oiio/

// clang-format off

#pragma once

#include <OpenImageIO/detail/fmt.h>

#include <OpenImageIO/half.h>

#ifndef OIIO_IMATH_H_INCLUDED
#define OIIO_IMATH_H_INCLUDED 1

// Determine which Imath we're dealing with and include the appropriate
// headers.

#define OIIO_USING_IMATH 3

#if OIIO_USING_IMATH >= 3
#   include <Imath/ImathColor.h>
#   include <Imath/ImathMatrix.h>
#   include <Imath/ImathVec.h>
#else
#   include <OpenEXR/ImathColor.h>
#   include <OpenEXR/ImathMatrix.h>
#   include <OpenEXR/ImathVec.h>
#endif


/// Custom fmtlib formatters for Imath types.

FMT_BEGIN_NAMESPACE
template<> struct formatter<Imath::V2f>
    : OIIO::pvt::array_formatter<Imath::V2f, float, 2> {};
template<> struct formatter<Imath::V3f>
    : OIIO::pvt::array_formatter<Imath::V3f, float, 3> {};
template<> struct formatter<Imath::V4f>
    : OIIO::pvt::array_formatter<Imath::V4f, float, 4> {};
#if OIIO_USING_IMATH >= 3
template<> struct formatter<Imath::M22f>
    : OIIO::pvt::array_formatter<Imath::M22f, float, 4> {};
#endif
template<> struct formatter<Imath::M33f>
    : OIIO::pvt::array_formatter<Imath::M33f, float, 9> {};
template<> struct formatter<Imath::M44f>
    : OIIO::pvt::array_formatter<Imath::M44f, float, 16> {};
FMT_END_NAMESPACE

#endif // !defined(OIIO_IMATH_H_INCLUDED)
