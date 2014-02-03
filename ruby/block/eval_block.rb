# Pair programming partner: Alexander Bryan

def eval_block(*args, &blk)
  if blk.nil?
    puts "NO BLOCK GIVEN!"
  else
    blk.call(*args)
  end
end
