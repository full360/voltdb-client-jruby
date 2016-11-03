describe Voltdb::ClientConfig do
  describe "#new" do
    context "when no username or password provided" do
      it "returns a Voltdb::ClientConfig object" do
        expect(described_class.new).to be_kind_of(Voltdb::ClientConfig)
      end
    end

    context "when username and password provided" do
      it "returns a Voltdb::ClientConfig object" do
        expect(described_class.new("admin", "pass")).to be_kind_of(Voltdb::ClientConfig)
      end
    end
  end
end
