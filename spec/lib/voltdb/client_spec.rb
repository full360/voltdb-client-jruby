describe Voltdb::Client do
  let(:config) { Voltdb::ClientConfig.new }
  let(:subject) { described_class.create_client(config) }

  describe ".create_client" do
    it "returns a Voltdb::ClientConfig object" do
      expect(subject).to be_kind_of(Voltdb::Client)
    end

    it "has a java_client attribute" do
      expect(subject.java_client)
        .to be_kind_of(Java::OrgVoltdbClient::ClientImpl)
    end
  end
end
