RSpec.describe HrrRbSsh::Messages::SSH_MSG_KEXDH_INIT do
  let(:id){ 'SSH_MSG_KEXDH_INIT' }
  let(:value){ 30 }

  describe "::ID" do
    it "is defined" do
      expect(described_class::ID).to eq id
    end
  end

  describe "::VALUE" do
    it "is defined" do
      expect(described_class::VALUE).to eq value
    end
  end

  let(:message){
    {
      :'message number' => value,
      :'e'              => 1234567890,
    }
  }
  let(:payload){
    [
      HrrRbSsh::DataTypes::Byte.encode(message[:'message number']),
      HrrRbSsh::DataTypes::Mpint.encode(message[:'e']),
    ].join
  }

  describe "#encode" do
    it "returns payload encoded" do
      expect(described_class.new.encode(message)).to eq payload
    end
  end

  describe "#decode" do
    it "returns message decoded" do
      expect(described_class.new.decode(payload)).to eq message
    end
  end
end
