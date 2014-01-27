require 'spec_helper'

describe Geo3d::Matrix do
  before :each do
    @gl_initialized = false
    #require "ruby-sdl-ffi"
    require "opengl"
    include Gl,Glu,Glut

    glutInit
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
    glutInitWindowSize(500, 500)
    glutInitWindowPosition(100, 100)
    glutCreateWindow('test')

=begin
    if SDL.Init(SDL::INIT_VIDEO) < 0
      puts "not able to init"
    else

      SDL.GL_SetAttribute SDL::GL_RED_SIZE, 5
      SDL.GL_SetAttribute SDL::GL_GREEN_SIZE, 5
      SDL.GL_SetAttribute SDL::GL_BLUE_SIZE, 5
      SDL.GL_SetAttribute SDL::GL_DEPTH_SIZE, 16
      SDL.GL_SetAttribute SDL::GL_DOUBLEBUFFER, 1

      if 0 == SDL.SetVideoMode(640, 480, SDL.GetVideoInfo.vfmt.BitsPerPixel, SDL::OPENGL)
        puts "not able to set video mode"
      else
        @gl_initialized = true
      end
    end
=end
 #   raise "opengl not able to initialize" unless @gl_initialized
  end

  it "the identity constructor should be functionally equivalent to glLoadIdentity" do
    glMatrixMode GL_MODELVIEW
    glLoadIdentity
    gl_version = Geo3d::Matrix.new *glGetFloatv(GL_MODELVIEW_MATRIX).flatten
    Geo3d::Matrix.identity.should == gl_version
  end

  it "the right handed view constructor should be functionally equivalent to gluLookAt" do
    [{:eye => [1, 0, 0], :focus => [100, 0, -100], :up => [0, 1, 0]}].each do |data|
      eye = Geo3d::Vector.new *data[:eye]
      focus = Geo3d::Vector.new *data[:eye]
      up = Geo3d::Vector.new *data[:eye]

      glMatrixMode GL_MODELVIEW
      glLoadIdentity
      gluLookAt eye.x, eye.y, eye.z, focus.x, focus.y, focus.z, up.x, up.y, up.z
      gl_version = Geo3d::Matrix.new *glGetFloatv(GL_MODELVIEW_MATRIX).flatten

      gl_version.should == Geo3d::Matrix.look_at_rh(eye, focus, up)
    end
  end

  it "gl_frustum should be equivalent to opengl glFrustum" do
    [{:l => -2, :r => 2, :b => -2, :t => 2, :zn => 1, :zf => 1000},
     {:l => -231, :r => 453, :b => -232, :t => 2786, :zn => 9.221, :zf => 10000}].each do |data|
      glMatrixMode GL_PROJECTION
      glLoadIdentity
      glFrustum data[:l], data[:r], data[:b], data[:t], data[:zn], data[:zf]

      gl_version = Geo3d::Matrix.new *(glGetFloatv(GL_PROJECTION_MATRIX).flatten)
      geo3d_matrix = Geo3d::Matrix.gl_frustum data[:l], data[:r], data[:b], data[:t], data[:zn], data[:zf]

      gl_version.should == geo3d_matrix
    end

  end

  it "glu_perspective_degrees should be equivalent to opengl gluPerspective" do
    [{:fovy_in_degrees => 60, :width => 640, :height => 480, :near => 0.1, :far => 1000}].each do |data|
      glMatrixMode GL_PROJECTION
      glLoadIdentity
      gluPerspective data[:fovy_in_degrees], data[:width].to_f/data[:height].to_f, data[:near], data[:far]

      gl_version = Geo3d::Matrix.new *glGetFloatv(GL_PROJECTION_MATRIX).flatten
      geo3d_matrix = Geo3d::Matrix.glu_perspective_degrees(data[:fovy_in_degrees], data[:width].to_f/data[:height].to_f, data[:near], data[:far])

      gl_version.should == geo3d_matrix
    end
  end

  it "gl_ortho should be equivalent to opengl glOrtho" do
    [{:l => -2, :r => 2, :b => -2, :t => 2, :zn => 1, :zf => 1000},
     {:l => -231, :r => 453, :b => -232, :t => 2786, :zn => 9.221, :zf => 10000}].each do |data|
      glMatrixMode GL_PROJECTION
      glLoadIdentity
      glOrtho data[:l], data[:r], data[:b], data[:t], data[:zn], data[:zf]

      gl_version = Geo3d::Matrix.new *(glGetFloatv(GL_PROJECTION_MATRIX).flatten)
      geo3d_matrix = Geo3d::Matrix.gl_ortho data[:l], data[:r], data[:b], data[:t], data[:zn], data[:zf]

      gl_version.should == geo3d_matrix
    end
  end

  it "should multiply matrices the same way opengl does" do
    10000.times do
      a_values = (0..15).to_a.map do |i|
        rand * rand(100)
      end

      b_values = (0..15).to_a.map do |i|
        rand * rand(100)
      end

      geo3d_matrix = Geo3d::Matrix.new(*b_values) * Geo3d::Matrix.new(*a_values)

      glMatrixMode GL_MODELVIEW
      glLoadIdentity
      glLoadMatrixf a_values
      glMultMatrixf b_values
      gl_version = Geo3d::Matrix.new *glGetFloatv(GL_MODELVIEW).flatten

      gl_version.should == geo3d_matrix
    end
  end

  it "should project a vector the same way gluProject does" do
    viewport_data = {:x => 0, :y => 0, :width => 640, :height => 480}
    projection_data = {:fovy_in_degrees => 60.0, :width => 640.0, :height => 480.0, :near => 0.1, :far => 1000.0}
    view_data = {:eye => [1.0, 0.0, 0.0], :focus => [200.0, -40.0, -100.0], :up => [0.0, 1.0, 0.0]}
    eye = Geo3d::Vector.new *view_data[:eye]
    focus = Geo3d::Vector.new *view_data[:focus]
    up = Geo3d::Vector.new *view_data[:up]


    viewport_matrix = Geo3d::Matrix.viewport viewport_data[:x], viewport_data[:y], viewport_data[:width], viewport_data[:height]
    projection_matrix = Geo3d::Matrix.glu_perspective_degrees(projection_data[:fovy_in_degrees], projection_data[:width].to_f/projection_data[:height].to_f, projection_data[:near], projection_data[:far])
    view_matrix = Geo3d::Matrix.look_at_rh(eye, focus, up)

    vector = Geo3d::Vector.new 300, 100, -500

    glu_vector = gluProject vector.x, vector.y, vector.z, projection_matrix.to_a, view_matrix.to_a, [viewport_data[:x], viewport_data[:y], viewport_data[:width], viewport_data[:height]]

    puts "glu vect is #{glu_vector.inspect}"
    Geo3d::Vector.new(*glu_vector).should == vector.project(viewport_matrix, projection_matrix, view_matrix, Geo3d::Matrix.identity).zero_w
  end

  it "should unproject a vector the same way gluUnproject does" do
    viewport_data = {:x => 0, :y => 0, :width => 640, :height => 480}
    projection_data = {:fovy_in_degrees => 60.0, :width => 640.0, :height => 480.0, :near => 0.1, :far => 1000.0}
    view_data = {:eye => [1.0, 0.0, 0.0], :focus => [200.0, -40.0, -100.0], :up => [0.0, 1.0, 0.0]}
    eye = Geo3d::Vector.new *view_data[:eye]
    focus = Geo3d::Vector.new *view_data[:focus]
    up = Geo3d::Vector.new *view_data[:up]


    viewport_matrix = Geo3d::Matrix.viewport viewport_data[:x], viewport_data[:y], viewport_data[:width], viewport_data[:height]
    projection_matrix = Geo3d::Matrix.glu_perspective_degrees(projection_data[:fovy_in_degrees], projection_data[:width].to_f/projection_data[:height].to_f, projection_data[:near], projection_data[:far])
    view_matrix = Geo3d::Matrix.look_at_rh(eye, focus, up)

    vector = Geo3d::Vector.new 574.1784279190967, 294.42147391181595, 0.8485367205965038

    glu_vector = gluUnProject vector.x, vector.y, vector.z, projection_matrix.to_a, view_matrix.to_a, [viewport_data[:x], viewport_data[:y], viewport_data[:width], viewport_data[:height]]
    Geo3d::Vector.new(*glu_vector).should == vector.unproject(viewport_matrix, projection_matrix, view_matrix, Geo3d::Matrix.identity).zero_w
  end


end