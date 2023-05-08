local CyclicTable = {}

function CyclicTable:new(table)
  self.table = table

  return self
end

function CyclicTable:next()
  self.pos, self.elem = next(self.table, self.pos)

  if not self.elem then
    self.pos, self.elem = next(self.table, self.pos)
  end

  return self.elem
end

return CyclicTable
