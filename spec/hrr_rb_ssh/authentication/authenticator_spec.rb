RSpec.describe HrrRbSsh::Authentication::Authenticator do
  describe ".new" do
    it "takes block" do
      expect { ( described_class.new { |context| "block" } ) }.not_to raise_error
    end

    it "does not take arguments" do
      expect { ( described_class.new ("arg") { |context| "block" } ) }.to raise_error ArgumentError
    end
  end

  describe "#authenticate" do
    let(:proc){ Proc.new do |context| context.to_s end }
    let(:authenticator){ described_class.new &proc }

    it "calls proc with context argument" do
      expect( authenticator.authenticate 123 ).to eq "123"
    end
  end
end
