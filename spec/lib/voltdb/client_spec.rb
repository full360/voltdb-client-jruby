describe Voltdb::Client do
  let(:config) { Voltdb::ClientConfig.new }
  let(:subject) { described_class.create_client(config) }
  let(:proccallback) { Voltdb::ProcCallback }

  describe ".create_client" do
    it "returns a Voltdb::ClientConfig object" do
      expect(subject).to be_kind_of(Voltdb::Client)
    end

    it "has a java_client attribute" do
      expect(subject.java_client)
        .to be_kind_of(Java::OrgVoltdbClient::ClientImpl)
    end
  end

  context "when mocked client" do
    let(:java_client) { spy("java_client") }

    before { allow(subject).to receive(:java_client).and_return(java_client) }

    describe "#call_procedure" do
      context "when sync call" do
        it "calls call_procedure with the correct params" do
          subject.call_procedure("proc_name", 123, "arg")

          expect(java_client)
            .to have_received(:call_procedure)
            .with("proc_name", 123, "arg")
        end
      end

      context "when async call" do
        let(:cb) { proccallback.new }

        it "calls call_procedure with the correct params" do
          allow(proccallback).to receive(:new).with(any_args).and_return(cb)

          subject.call_procedure("proc_name", 123, "arg") {}

          expect(java_client)
            .to have_received(:call_procedure)
            .with(cb, "proc_name", 123, "arg")
        end
      end
    end

    describe "#call_procedure_with_timeout" do
      context "when sync call" do
        it "calls call_procedure_with_timeout with the correct params" do
          subject.call_procedure_with_timeout(1000, "proc_name", 123, "arg")

          expect(java_client)
            .to have_received(:call_procedure_with_timeout)
            .with(1000, "proc_name", 123, "arg")
        end
      end

      context "when async call" do
        let(:cb) { proccallback.new }

        it "calls call_procedure_with_timeout with the correct params" do
          allow(proccallback).to receive(:new).with(any_args).and_return(cb)

          subject.call_procedure_with_timeout(1000, "proc_name", 123, "arg") {}

          expect(java_client)
            .to have_received(:call_procedure_with_timeout)
            .with(cb, 1000, "proc_name", 123, "arg")
        end
      end
    end

    describe "#update_application_catalog" do
      context "when sync call" do
        it "calls update_application_catalog with the correct params" do
          subject.update_application_catalog("some_path", "deployment_path")

          expect(java_client)
            .to have_received(:update_application_catalog)
            .with("some_path", "deployment_path")
        end
      end

      context "when async call" do
        let(:cb) { proccallback.new }

        it "calls update_application_catalog with the correct params" do
          allow(proccallback).to receive(:new).with(any_args).and_return(cb)

          subject.update_application_catalog("some_path", "deployment_path") {}

          expect(java_client)
            .to have_received(:update_application_catalog)
            .with(cb, "some_path", "deployment_path")
        end
      end
    end

    describe "#update_classes" do
      context "when sync call" do
        it "calls update_classes with the correct params" do
          subject.update_classes("jar_path", "Class1,Class2")

          expect(java_client)
            .to have_received(:update_classes)
            .with("jar_path", "Class1,Class2")
        end
      end

      context "when async call" do
        let(:cb) { proccallback.new }

        it "calls update_classes with the correct params" do
          allow(proccallback).to receive(:new).with(any_args).and_return(cb)

          subject.update_classes("jar_path", "Class1,Class2") {}

          expect(java_client)
            .to have_received(:update_classes)
            .with(cb, "jar_path", "Class1,Class2")
        end
      end
    end

    describe "#get_new_bulk_loader" do
      let(:blfcb) { Voltdb::BulkLoaderFailureCallback }
      let(:cb) { blfcb.new }

      context "when sync call" do
        it "calls get_new_bulk_loader with the correct params" do
          allow(blfcb).to receive(:new).with(any_args).and_return(cb)

          subject.get_new_bulk_loader("table", 10, false) {}

          expect(java_client)
            .to have_received(:get_new_bulk_loader)
            .with("table", 10, cb)
        end
      end

      context "when async call" do
        it "calls get_new_bulk_loader with the correct params" do
          allow(blfcb).to receive(:new).with(any_args).and_return(cb)

          subject.get_new_bulk_loader("table", 10, true) {}

          expect(java_client)
            .to have_received(:get_new_bulk_loader)
            .with("table", 10, true, cb)
        end
      end
    end

    describe "#call_all_partition_procedure" do
      context "when sync call" do
        it "calls call_all_partition_procedure with the correct params" do
          subject.call_all_partition_procedure("proc_name", 123, "arg")

          expect(java_client)
            .to have_received(:call_all_partition_procedure)
            .with("proc_name", 123, "arg")
        end
      end

      context "when async call" do
        let(:appcb) { Voltdb::AllPartitionProcCallback }
        let(:cb) { appcb.new }

        it "calls call_procedure with the correct params" do
          allow(appcb).to receive(:new).with(any_args).and_return(cb)

          subject.call_all_partition_procedure("proc_name", 123, "arg") {}

          expect(java_client)
            .to have_received(:call_all_partition_procedure)
            .with(cb, "proc_name", 123, "arg")
        end
      end
    end
  end
end
