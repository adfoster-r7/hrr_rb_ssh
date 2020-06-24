RSpec.describe HrrRbSsh::Transport::ServerHostKeyAlgorithm::SshDss do
  let(:name){ 'ssh-dss' }

  it "can be looked up in HrrRbSsh::Transport::ServerHostKeyAlgorithm dictionary" do
    expect( HrrRbSsh::Transport::ServerHostKeyAlgorithm[name] ).to eq described_class
  end

  it "is registered in HrrRbSsh::Transport::ServerHostKeyAlgorithm.list_supported" do
    expect( HrrRbSsh::Transport::ServerHostKeyAlgorithm.list_supported ).to include name
  end

  it "appears in HrrRbSsh::Transport::ServerHostKeyAlgorithm.list_preferred" do
    expect( HrrRbSsh::Transport::ServerHostKeyAlgorithm.list_preferred ).to include name
  end

  context "when secret_key is specified" do
    let(:server_host_key_algorithm){ described_class.new secret_key }
    let(:secret_key){
      <<-'EOB'
-----BEGIN DSA PRIVATE KEY-----
MIIBuwIBAAKBgQD3fQ6cwTtOJpVI0iASOQZxkhwPRNy7UwovQkEK6bXW33HaCebO
PnNiY/rR4uFhjvHRzF8KnC8xk3fNo4ZJQJlaEHv6qySiXHeX1fw/eo/uzM5WafLd
oaRtE2muky1i3FBCiboXDlNcwuA/efsOE5qsGBbk6svw+8pGolHmOZFSvQIVAN2G
ZxtE9Kqqh6z48/VulQZsrh5hAoGAH3191okH8kUwP3dinp5j5YtNzrJ20sBXNNZG
0aWjtS2xjSjIXjnlkiwhhvcUcCEkUQ507exvSLgf4dyV/V4+nf5Q5zjLztiSMe9D
qhTRIR23lsDu0OdITQihTu+Y4GEvNLUL9r2P1aoF/sde97xzzqmXPKx0UL1nNzcL
dnAdjjMCgYAa1dRvXe65jufPk0kRwhewRSScfg+YK4DOLUYGalsjHZbXtXqHKNpB
YkTlWKMg6QVREN0+5aNY1z1aJAbNboLz55YBnS9tOBYzvsXQF7ZP1ECMO6m4I8DI
wxt35i8hEVOJc+8x/xtmogzbjepar+1UycJQTMjhvqCW7RF4LuepvwIVANELTvnl
MRl/p42OrQzL/chRPvRf
-----END DSA PRIVATE KEY-----
      EOB
    }

    describe '#server_public_host_key' do
      it "returns encoded \"ssh-dss\" || p || g || q || y" do
        encoded_server_public_host_key = \
          "00000007" "7373682d" "64737300" "00008100" \
          "f77d0e9c" "c13b4e26" "9548d220" "12390671" \
          "921c0f44" "dcbb530a" "2f42410a" "e9b5d6df" \
          "71da09e6" "ce3e7362" "63fad1e2" "e1618ef1" \
          "d1cc5f0a" "9c2f3193" "77cda386" "4940995a" \
          "107bfaab" "24a25c77" "97d5fc3f" "7a8feecc" \
          "ce5669f2" "dda1a46d" "1369ae93" "2d62dc50" \
          "4289ba17" "0e535cc2" "e03f79fb" "0e139aac" \
          "1816e4ea" "cbf0fbca" "46a251e6" "399152bd" \
          "00000015" "00dd8667" "1b44f4aa" "aa87acf8" \
          "f3f56e95" "066cae1e" "61000000" "801f7d7d" \
          "d68907f2" "45303f77" "629e9e63" "e58b4dce" \
          "b276d2c0" "5734d646" "d1a5a3b5" "2db18d28" \
          "c85e39e5" "922c2186" "f7147021" "24510e74" \
          "edec6f48" "b81fe1dc" "95fd5e3e" "9dfe50e7" \
          "38cbced8" "9231ef43" "aa14d121" "1db796c0" \
          "eed0e748" "4d08a14e" "ef98e061" "2f34b50b" \
          "f6bd8fd5" "aa05fec7" "5ef7bc73" "cea9973c" \
          "ac7450bd" "6737370b" "76701d8e" "33000000" \
          "801ad5d4" "6f5deeb9" "8ee7cf93" "4911c217" \
          "b045249c" "7e0f982b" "80ce2d46" "066a5b23" \
          "1d96d7b5" "7a8728da" "416244e5" "58a320e9" \
          "055110dd" "3ee5a358" "d73d5a24" "06cd6e82" \
          "f3e79601" "9d2f6d38" "1633bec5" "d017b64f" \
          "d4408c3b" "a9b823c0" "c8c31b77" "e62f2111" \
          "538973ef" "31ff1b66" "a20cdb8d" "ea5aafed" \
          "54c9c250" "4cc8e1be" "a096ed11" "782ee7a9" \
          "bf"
        expect( server_host_key_algorithm.server_public_host_key ).to eq [encoded_server_public_host_key].pack("H*")
      end
    end

    describe '#verify' do
      let(:data){ 'testing' }

      context "with correct sign" do
        let(:sign){ server_host_key_algorithm.sign(data) }

        it "returns true" do
          expect( server_host_key_algorithm.verify sign, data ).to be true
        end
      end

      context "with not \"ssh-dss\"" do
        let(:encoded_data){
          "00000007" "01234567" "01234500" "000028dd" \
          "0c8ad315" "a3f59dde" "e8a42cfb" "3b40c459" \
          "de0df3d6" "d6f39961" "c0b7ee85" "183ffc1c" \
          "5f2f9c99" "ad5e12"
        }
        let(:sign){ [encoded_data].pack("H*") }

        it "returns false" do
          expect( server_host_key_algorithm.verify sign, data ).to be false
        end
      end

      context "with incorrect sign" do
        let(:encoded_data){
          "00000007" "7373682d" "64737367" "01234567" \
          "01234567" "01234567" "01234567" "01234567" \
          "01234567" "01234567" "01234567" "01234567" \
          "01234567" "013456"
        }
        let(:sign){ [encoded_data].pack("H*") }

        it "returns false" do
          expect( server_host_key_algorithm.verify sign, data ).to be false
        end
      end
    end
  end

  context "when secret_key is not specified" do
    let(:server_host_key_algorithm){ described_class.new }

    describe '#verify' do
      let(:data){ 'testing' }

      context "with correct sign" do
        let(:sign){ server_host_key_algorithm.sign(data) }

        it "returns true" do
          expect( server_host_key_algorithm.verify sign, data ).to be true
        end
      end
    end
  end
end
