#!/usr/bin/env ruby
# requires ffmpeg 2.6+

# Creates a palette on the first pass by analyzing the movie
# The second pass creates the gif, scaling it down.
# From: http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html#usage

require 'optparse'
options = {}

class Options
  attr_accessor :input, :output, :start_time, :duration, :scale, :fps

  attr_reader :palette

  def initialize
    @palette = '/tmp/palette.png'
  end

  def first_pass_args
    args = []
    args << "-v warning"
    args << "-ss #{start_time}" if start_time
    args << "-t #{duration}" if duration
    args << "-i \"#{input}\" -vf \"#{filters},palettegen\" -y #{palette}"
    args.join(' ')
  end

  def second_pass_args
    args = []
    args << "-v warning"
    args << "-ss #{start_time}" if start_time
    args << "-t #{duration}" if duration
    args << "-i \"#{input}\" -i #{palette} -lavfi \"#{filters} [x]; [x][1:v] paletteuse\" -y \"#{output}\""
    args.join(' ')
  end

  def filters
    self.scale ||= 320
    self.fps ||= 15
    "fps=#{fps},scale=#{scale}:-1:flags=lanczos"
  end

  def empty?
    input.nil? || output.nil?
  end
end

options = Options.new

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: gifenc.rb [options]"

  opts.on("-iMOVIE", "--input=MOVIE", "Input movie") do |v|
    options.input = v
  end

  opts.on("-oGIF", "--output=GIF", "Output gif") do |v|
    options.output = v
  end

  opts.on("-sSTART_TIME", "--start_time=START_TIME", "Start time (in seconds, or hh:mm:ss)") do |v|
    options.start_time = v
  end

  opts.on("-tDURATION", "--time=DURATION", "Duration (in seconds, or hh:mm:ss)") do |v|
    options.duration = v
  end

  opts.on("--scale=SCALE", "Scale in pixels (default is 320)") do |v|
    options.scale = v
  end

  opts.on("--fps=FPS", "FPS (defaults to 15fps)") do |v|
    options.fps = v
  end

  opts.on("-h", "-?", "--help", "This message") do
    puts opts
    exit
  end
end

opt_parser.parse!

if options.empty?
  puts opt_parser
  exit
end

`ffmpeg #{options.first_pass_args}`
`ffmpeg #{options.second_pass_args}`
