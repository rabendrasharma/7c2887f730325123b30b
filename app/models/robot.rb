class Robot < ApplicationRecord
  has_many :grids
  DIRECTION_ANGLES = {90=> 'WEST', 180=> 'NORTH', 270=> 'EAST'}

  def create_order(params)
    x_coordinate,y_coordinate,direction = calculate_position_and_direction(params)
    order = Order.create(commands: params[:commands])
    Grid.create(x_coordinate: x_coordinate, y_coordinate: y_coordinate, direction: direction, robot_id: params[:robot_id])
    if params[:commands].last.split(' ').last == 'REPORT'
      [x_coordinate,y_coordinate,direction]
    else
      []
    end
  end

  def calculate_position_and_direction(params)
    x_coordinate, y_coordinate, direction = coordinate_splitter(params)
    params[:commands][1].split(" ").each do |command|
      if command == 'NORTH' || direction == 'NORTH'
        axis = 'y'
        value = 1
        direction = direction
      elsif command == 'SOUTH' || direction == 'SOUTH'
        axis = 'y'
        value = -1
        direction = direction
      elsif command == 'EAST' || direction == 'EAST'
        axis = 'x'
        value = 1
        direction = direction
      elsif command == 'WEST' || direction == 'WEST'
        axis = 'x'
        value = -1
        direction = direction
      end
      if command == 'MOVE'
        if axis == 'x'
          x_coordinate += value
        else
          y_coordinate += value
        end
      end
      if command == 'LEFT'
        angle = DIRECTION_ANGLES.invert[direction] - 90
        direction = DIRECTION_ANGLES[angle]
      elsif command == 'LEFT'
        angle = DIRECTION_ANGLES.invert[direction] + 90
        direction = DIRECTION_ANGLES[angle]
      end
    end
    [x_coordinate,y_coordinate,direction]
  end


  def coordinate_splitter(params)
    x_coordinate, y_coordinate, direction = params[:commands][0].split(' ')[1].split(',')
    x_coordinate = x_coordinate.to_i
    y_coordinate = y_coordinate.to_i
    [x_coordinate, y_coordinate, direction]
  end
end
