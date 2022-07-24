class Api::RobotController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_robot
  before_action :validate_params

  def orders
    result = @robot.create_order(params)
    render json: {location: result}
  end

  private

  def find_robot
    @robot = Robot.find_by_id(params[:id])
  end

  def validate_params
    error('Invalid Commands') unless params.key?('commands') && params['commands'].class == Array && params['commands'][0].include?('PLACE')

    x_coordinate, y_coordinate, direction = params[:commands][0].split(' ')[1].split(',')
    error('Invalid Coordinates') unless x_coordinate.to_i <= 4 || y_coordinate.to_i <= 4

    error('Robot not found') unless @robot
  end
end
