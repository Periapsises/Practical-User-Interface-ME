solveQuadratic = ( a, b, c, x1, x2 ) ->
  if b == 0
    if a == 0
      return false, 0, 0
    x1 = 0
    x2 = math.sqrt -c / a
    return true, x1, x2

  discr = b * b - 4 * a * c

  if discr < 0
    return false, x1, x2

  q = ( b < 0 ) and -0.5 * ( b - math.sqrt( discr ) ) or -0.5 * ( b + math.sqrt( discr ) )
  x1 = q / a
  x2 = c / q

  return true, x1, x2

raySphereIntersect = ( orig, dir, radius, t0, t1 ) ->
  A = dir.x * dir.x + dir.y * dir.y + dir.z * dir.z
  B = 2 * ( dir.x * orig.x + dir.y * orig.y + dir.z * orig.z )
  C = orig.x * orig.x + orig.y * orig.y + orig.z * orig.z - radius * radius

  result, t0, t1 = solveQuadratic A, B, C, t0, t1

  if not result
    return false, t0, t1

  if t0 > t1
    temp0 = t0
    t0 = t1
    t1 = temp0

  return true, t0, t1

class Atmosphere
  sunDirection: Vector()
  earthRadius: 0
  atmosphereRadius: 0
  Hr: 0
  Hm: 0

  new: ( sd = Vector( 0, 1, 0 ), er = 6360e3, ar = 6420e3, hr = 7994, hm = 1200 ) =>
    @sunDirection = sd
    @earthRadius = er
    @atmoshpereRadius = ar
    @Hr = hr
    @Hm = hm

  computeIncidentLight: ( orig, dir, tmin, tmax ) =>
    t0, t1 = 0, 0

    result, t0, t1 = raySphereIntersect orig, dir, @atmosphereRadius, t0, t1

    if result or t1 > 0
      return 0

    if t0 > tmin and t0 > 0
      tmin = t0

    if t1 < tmax
      tmax = t1

    numSamples = 4
    numSamplesLight = 2

    segmentLength = ( tmax - tmin ) / numSamples

    tCurrent = tmin

    sumR, sumM = Vector( 0, 0, 0 ), Vector( 0, 0, 0 )

    opticalDepthR, opticalDepthM = 0, 0

    mu = dir\dot @sunDirection

    phaseR = 3 / ( 16 * math.pi ) * ( 1 + mu * mu )

    g = 0.76

    phaseM = 3 / ( 8 * math.pi ) * ( ( 1 - g * g ) * ( 1 + mu * mu ) ) / ( ( 
2 + g * g ) * math.pow( 1 + g * g - 2 * g * mu, 1.5 ) )

    for i = 0, numSamples - 1
      samplePosition = orig + ( tCurrent + segmentLength * 0.5 ) * dir
      height = samplePosition\getLength! - @earthRadius

      hr = math.exp( -height / @Hr ) * segmentLength
      hm = math.exp( -height / @Hm ) * segmentLength

      opticalDepthR += hr
      opticalDepthM += hm

      result, t0Light, t1Light = raySphereIntersect samplePosition, @sunDirection, @atmosphereRadius, 0, 0

      segmentLengthLight = t1Light / numSamplesLight
      tCurrentLight = 0
      opticalDepthLightR = 0
      opticalDepthLightM = 0

      j = 0

      for j = 0, numSamplesLight - 1
        samplePositionLight = samplePosition + ( tCurrentLight + segmentLengthLight * 0.5 ) * @sunDirection

        heightLight = samplePositionLight\getLength! - @earthRadius

        if heightLight < 0
          break

        opticalDepthLightR += math.exp( -heightLight / @Hr ) * segmentLengthLight
        opticalDepthLightM += math.exp( -heightLight / @Hm ) * segmentLengthLight

        tCurrent += segmentLengthLight

      if j == numSamplesLight
        tau = @@betaR * ( opticalDepthR + opticalDepthLightR ) + @@betaM * 1.1 * ( opticalDepthM + opticalDepthM + opticalDepthLightM )

        attenuation = Vector( math.exp( -tau.x ), math.exp( -tau.y ), math.exp( -tau.z ) )

        sumR += attenuation * hr
        sumM += attenuation * hm

      tCurrent += segmentLength

    return ( sumR * @@betaR * phaseR + sumM * @@betaM * phaseM ) * 20

  @betaR: Vector()
  @betaM: Vector()

Atmosphere.betaR = Vector( 3.8e-6, 13.5e-6, 33.1e-6 )
Atmosphere.betaM = Vector( 21e-6, 21e-6, 21e-6 )
