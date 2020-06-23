# coding: utf-8
# vim: et ts=2 sw=2

RSpec.describe HrrRbSsh::Messages::SSH_MSG_IGNORE do
  let(:id){ 'SSH_MSG_IGNORE' }
  let(:value){ 2 }

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
      :'data'           => 'ignored',
    }
  }
  let(:payload){
    [
      HrrRbSsh::DataTypes::Byte.encode(message[:'message number']),
      HrrRbSsh::DataTypes::String.encode(message[:'data']),
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
