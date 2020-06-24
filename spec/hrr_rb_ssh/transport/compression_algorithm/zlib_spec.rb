RSpec.describe HrrRbSsh::Transport::CompressionAlgorithm::Zlib do
  let(:name){ 'zlib' }
  let(:compression_algorithm){ described_class.new direction }

  it "can be looked up in HrrRbSsh::Transport::CompressionAlgorithm dictionary" do
    expect( HrrRbSsh::Transport::CompressionAlgorithm[name] ).to eq described_class
  end

  it "is registered in HrrRbSsh::Transport::CompressionAlgorithm.list_supported" do
    expect( HrrRbSsh::Transport::CompressionAlgorithm.list_supported ).to include name
  end

  it "not appears in HrrRbSsh::Transport::CompressionAlgorithm.list_preferred" do
    expect( HrrRbSsh::Transport::CompressionAlgorithm.list_preferred ).to include name
  end

  context "when direction is outgoing" do
    let(:direction){ HrrRbSsh::Transport::Direction::OUTGOING }

    after :example do
      compression_algorithm.close
    end

    describe '#deflate' do
      context "deflate once" do
        let(:test_data){ "test data" }
        let(:first_deflated){ ["789c2a492d2e5148492c4904000000ffff"].pack("H*") }

        it "returns deflated data" do
          expect( compression_algorithm.deflate test_data ).to eq first_deflated
        end
      end

      context "deflate multiple times" do
        let(:test_data){ "test data" }
        let(:first_deflated) { ["789c2a492d2e5148492c4904000000ffff"].pack("H*") }
        let(:second_deflated){ ["2a813100000000ffff"].pack("H*") }
        let(:third_deflated) { ["823300000000ffff"].pack("H*") }
        let(:fourth_deflated){ ["823300000000ffff"].pack("H*") }

        it "returns deflated data" do
          expect( compression_algorithm.deflate test_data ).to eq first_deflated
          expect( compression_algorithm.deflate test_data ).to eq second_deflated
          expect( compression_algorithm.deflate test_data ).to eq third_deflated
          expect( compression_algorithm.deflate test_data ).to eq fourth_deflated
        end
      end
    end

    describe '#close' do
      it "closes deflator" do
        compression_algorithm.close
        expect(compression_algorithm.instance_variable_get('@deflator').closed?).to be true
      end
    end
  end

  context "when direction is incoming" do
    let(:direction){ HrrRbSsh::Transport::Direction::INCOMING }

    after :example do
      compression_algorithm.close
    end

    describe '#inflate' do
      context "inflate once" do
        let(:test_data){ "test data" }
        let(:first_deflated){ ["789c2a492d2e5148492c4904000000ffff"].pack("H*") }

        it "returns data without inflate" do
          expect( compression_algorithm.inflate first_deflated ).to eq test_data
        end
      end

      context "inflate multiple times" do
        let(:test_data){ "test data" }
        let(:first_deflated ){ ["789c2a492d2e5148492c4904000000ffff"].pack("H*") }
        let(:second_deflated){ ["2a813100000000ffff"].pack("H*") }
        let(:third_deflated ){ ["823300000000ffff"].pack("H*") }
        let(:fourth_deflated){ ["823300000000ffff"].pack("H*") }

        it "returns inflated data" do
          expect( compression_algorithm.inflate first_deflated  ).to eq test_data
          expect( compression_algorithm.inflate second_deflated ).to eq test_data
          expect( compression_algorithm.inflate third_deflated  ).to eq test_data
          expect( compression_algorithm.inflate fourth_deflated ).to eq test_data
        end
      end
    end

    describe '#close' do
      it "closes inflator" do
        compression_algorithm.close
        expect(compression_algorithm.instance_variable_get('@inflator').closed?).to be true
      end
    end
  end
end
