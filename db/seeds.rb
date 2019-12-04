i = 1
length = Category.all.length

while i <= length
  a = Category.find(i)
  if a.parent_id == nil
    CategoryHierarchy.create(ancestor_id: a.id, descendant_id: a.id, generations: 0)
  else
    b = Category.find(a.parent_id)
    if b.parent_id == nil 
      CategoryHierarchy.create(ancestor_id: a.id, descendant_id: a.id, generations: 0)
      CategoryHierarchy.create(ancestor_id: b.id, descendant_id: a.id, generations: 1)
    else
      c = Category.find(b.parent_id) 
      CategoryHierarchy.create(ancestor_id: a.id, descendant_id: a.id, generations: 0)
      CategoryHierarchy.create(ancestor_id: b.id, descendant_id: a.id, generations: 1)
      CategoryHierarchy.create(ancestor_id: c.id, descendant_id: a.id, generations: 2)
    end
  end
  i += 1
end
