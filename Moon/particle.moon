export Particle

import insert, remove from table

class Particle
  -- Class data
  @particles: {}

  -- Instance data
  pos: Vector 0, 0
  vel: Vector 0, 0

  size: Vector 16, 16

  color: Color 255, 255, 255, 255

  deathtime: 0
  lifetime: 0

  new: ( pos, size, vel, lifespan ) =>
    @pos = pos or @pos
    @vel = vel or @vel
    @size = size or @size

    @deathtime = timer.curtime! + lifespan
    @lifetime = lifespan

    insert @@particles, @

  SetColor: ( color ) =>
    @color = color or Color 255, 255, 255, 255

  Update: =>
    @pos = @pos + @vel
 
  Draw: =>
    render.setColor @color
    render.drawRect @pos.x - @size.x / 2, @pos.y - @size.y / 2, @size.x, @size.y

hook.add "render", "update_particles", ->
  for id, particle in pairs Particle.particles
    particle.lifetime = particle.deathtime - timer.curtime!
    if particle.lifetime > 0
      particle\Update!
      particle\Draw!
    else
      remove Particle.particles, id