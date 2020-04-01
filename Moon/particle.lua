local insert, remove
do
  local _obj_0 = table
  insert, remove = _obj_0.insert, _obj_0.remove
end
do
  local _class_0
  local _base_0 = {
    pos = Vector(0, 0),
    vel = Vector(0, 0),
    size = Vector(16, 16),
    color = Color(255, 255, 255, 255),
    deathtime = 0,
    lifetime = 0,
    SetColor = function(self, color)
      self.color = color or Color(255, 255, 255, 255)
    end,
    Update = function(self)
      self.pos = self.pos + self.vel
    end,
    Draw = function(self)
      render.setColor(self.color)
      return render.drawRect(self.pos.x - self.size.x / 2, self.pos.y - self.size.y / 2, self.size.x, self.size.y)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, pos, size, vel, lifespan)
      self.pos = pos or self.pos
      self.vel = vel or self.vel
      self.size = size or self.size
      self.deathtime = timer.curtime() + lifespan
      self.lifetime = lifespan
      return insert(self.__class.particles, self)
    end,
    __base = _base_0,
    __name = "Particle"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.particles = { }
  Particle = _class_0
end
return hook.add("render", "update_particles", function()
  for id, particle in pairs(Particle.particles) do
    particle.lifetime = particle.deathtime - timer.curtime()
    if particle.lifetime > 0 then
      particle:Update()
      particle:Draw()
    else
      remove(Particle.particles, id)
    end
  end
end)
