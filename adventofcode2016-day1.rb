# 616112-20191025-4ee1e5ac

instructions = ""

File.open("day1-instructions.txt").each do |line|
    instructions = line
end

directions = instructions.split(',')
facing = "NORTH"
coord_x = 0
coord_y = 0
visited_locations = Hash.new(0)

def update_hash(hash, x, y)
    key = x.to_s + ',' + y.to_s

    hash[key] += 1

    if hash[key] > 1
        # we've been here once before!
        print "We've been to (" + x.to_s + ',' + y.to_s + ") before! "
        #blocks = x.abs + y.abs
        puts "Distance to Easter Bunny HQ is #{x.abs + y.abs}"
        return true
    end

    return false
end

found = false

directions.each do |direction|
    turn, distance = direction.strip.split(//, 2)

    if turn != "R" && turn != "L"
        puts "unknown turn '#{turn}'"
        break
    end
    num_blocks = distance.to_i

    if facing == "NORTH"
        if turn == "R"
            facing = "EAST"
            num_blocks.times do
                coord_x += 1
                break if found = update_hash(visited_locations, coord_x, coord_y)
            end
        else # turn == "L"
            facing = "WEST"
            num_blocks.times do
                coord_x -= 1
                break if found = update_hash(visited_locations, coord_x, coord_y)
            end
        end
    elsif facing == "SOUTH"
        if turn == "R"
            facing = "WEST"
            num_blocks.times do
                coord_x -= 1
                break if found = update_hash(visited_locations, coord_x, coord_y)
            end
        else # turn == "L"
            facing = "EAST"
            num_blocks.times do
                coord_x += 1
                break if found = update_hash(visited_locations, coord_x, coord_y)
            end
        end
    elsif facing == "EAST"
        if turn == "R"
            facing = "SOUTH"
            num_blocks.times do
                coord_y -= 1
                break if found = update_hash(visited_locations, coord_x, coord_y)
            end
        else # turn == "L"
            facing = "NORTH"
            num_blocks.times do
                coord_y += 1
                break if found = update_hash(visited_locations, coord_x, coord_y)
            end
        end
    elsif facing == "WEST"
        if turn == "R"
            facing = "NORTH"
            num_blocks.times do
                coord_y += 1
                break if found = update_hash(visited_locations, coord_x, coord_y)
            end
        else # turn == "L"
            facing = "SOUTH"
            num_blocks.times do
                coord_y -= 1
                break if found = update_hash(visited_locations, coord_x, coord_y)
            end
        end
    else
        puts "something went very wrong!"
    end

    print turn + distance.to_s + " => ("
    puts coord_x.to_s + ',' + coord_y.to_s + ")"

    break if found
end

# puts visited_locations

#blocks = coord_y.abs + coord_x.abs
#puts "distance to Easter Bunny HQ is #{blocks}"
