RSpec.describe HrrRbSsh::Messages::SSH_MSG_GLOBAL_REQUEST do
  let(:id){ 'SSH_MSG_GLOBAL_REQUEST' }
  let(:value){ 80 }

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

  context "when 'request name' is \"tcpip-forward\"" do
    let(:message){
      {
        :'message number'      => value,
        :'request name'        => 'tcpip-forward',
        :'want reply'          => false,
        :'address to bind'     => '0.0.0.0',
        :'port number to bind' => 1080,
      }
    }
    let(:payload){
      [
        HrrRbSsh::DataTypes::Byte.encode(message[:'message number']),
        HrrRbSsh::DataTypes::String.encode(message[:'request name']),
        HrrRbSsh::DataTypes::Boolean.encode(message[:'want reply']),
        HrrRbSsh::DataTypes::String.encode(message[:'address to bind']),
        HrrRbSsh::DataTypes::Uint32.encode(message[:'port number to bind']),
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

  context "when 'request name' is \"cancel-tcpip-forward\"" do
    let(:message){
      {
        :'message number'      => value,
        :'request name'        => 'cancel-tcpip-forward',
        :'want reply'          => false,
        :'address to bind'     => '0.0.0.0',
        :'port number to bind' => 1080,
      }
    }
    let(:payload){
      [
        HrrRbSsh::DataTypes::Byte.encode(message[:'message number']),
        HrrRbSsh::DataTypes::String.encode(message[:'request name']),
        HrrRbSsh::DataTypes::Boolean.encode(message[:'want reply']),
        HrrRbSsh::DataTypes::String.encode(message[:'address to bind']),
        HrrRbSsh::DataTypes::Uint32.encode(message[:'port number to bind']),
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
end
