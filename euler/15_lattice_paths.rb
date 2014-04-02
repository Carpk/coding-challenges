
# Starting in the top left corner of a 2×2 grid, and only 
# being able to move to the right and down, there are 
# exactly 6 routes to the bottom right corner.

#           .
#         .   .
#       .   .   .
#         .   .  
#           .   


# How many such routes are there through a 20×20 grid?

#           .
#         .   .
#       .   .   .
#     .   .   .   .
#       .   .   .
#         .   .
#           . 


def lattice_path(length)
  @route ||= 0
  unless length == 0
    length -= 1
    lattice_path(length)
    lattice_path(length)
  else
    @route += 1
  end
  @route
end


puts lattice_path(20) * 2 -2

