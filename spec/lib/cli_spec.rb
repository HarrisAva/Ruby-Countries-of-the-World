require_relative "../../lib/cli.rb"

RSpec.describe CLI do
  describe "#start" do
    it "prints a welcome message and asks the user for their name" do
      cli = CLI.new

      # Stubbing the standard input to simulate user input
      allow(cli).to receive(:gets).and_return("John Doe\n")

      # Expecting specific output to standard output
      expect { cli.start }.to output(
        "Welcome to the Countries of the World CLI!\nWhat is your name?\nHello John Doe!\n"
      ).to_stdout
    end
  end
end