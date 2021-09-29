class GenerateGem < ApplicationSubcommand
  def execute
    @logger = Logger.new(STDOUT)
    @logger.info 'Start generate-gem subcommand'
  end
end
