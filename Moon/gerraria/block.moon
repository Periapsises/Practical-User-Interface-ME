export Block, Blocks

Blocks = {}
BlockIDs = {}

class Block
  @id: 0
  @uvCoords: Vector 0, 0

  @Draw: ( x, y, w, h ) =>
    uvSize = 16 / 1024

    uvMin = @uvCoords * uvSize
    uvMax = uvMin + Vector( uvSize, uvSize )

    render.drawTexturedRectUV x, y, w, h, uvMin.x, uvMin.y, uvMax.x, uvMax.y

  -- Private fields
  @RegisterBlock: ( blockClass ) =>
    Blocks[blockClass._name] = blockClass
    BlockIDs[blockClass.id] = Blocks[blockClass._name]

  @GetBlockByID: ( id ) =>
    return BlockIDs[id]

