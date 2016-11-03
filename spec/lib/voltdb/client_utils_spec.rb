describe Voltdb::ClientUtils do
  let(:subject) { Object.new.extend(described_class) }

  describe "#params_to_java_objects" do
    context "when DateTime is in the params" do
      let(:params) { DateTime.new(2016, 10, 31) }

      it "returns a VoltDB TimestampType instead of DateTime" do
        expect(subject.params_to_java_objects(params)[0])
          .to be_kind_of(Java::OrgVoltdbTypes::TimestampType)
      end
    end

    context "when Date is in the params" do
      let(:params) { Date.new(2016, 10, 31) }

      it "returns a VoltDB TimestampType instead of Date" do
        expect(subject.params_to_java_objects(params)[0])
          .to be_kind_of(Java::OrgVoltdbTypes::TimestampType)
      end
    end

    context "when DateTime is in the params" do
      let(:params) { Time.new.utc }

      it "returns a VoltDB TimestampType instead of Time" do
        expect(subject.params_to_java_objects(params)[0])
          .to be_kind_of(Java::OrgVoltdbTypes::TimestampType)
      end
    end
  end

  describe "#host_and_port_from_address" do
    context "when only host is given" do
      it "returns an array of host and port" do
        expect(subject.host_and_port_from_address("localhost")).to eq(["localhost", 21212])
      end
    end

    context "when host and port are given" do
      it "returns an array of host and port" do
        expect(subject.host_and_port_from_address("localhost:21213")).to eq(["localhost", 21213])
      end
    end

    context "when none are given" do
      it "returns an array of host and port" do
        expect(subject.host_and_port_from_address("")).to eq(["", 0])
      end
    end
  end
end
