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
      let(:fcb) { blfcb.new }
      let(:blscb) { Voltdb::BulkLoaderSuccessCallback }
      let(:scb) { blscb.new }
      let(:upsert) { false }
      let(:failure) { Proc.new {} }
      let(:success) { Proc.new {} }

      context "when using only the failed callback" do
        context "when upsert is false used" do
          it "calls get_new_bulk_loader with the correct params" do
            allow(blfcb).to receive(:new).with(any_args).and_return(fcb)

            subject.get_new_bulk_loader("table", 10, upsert, failure)

            expect(java_client)
              .to have_received(:get_new_bulk_loader)
              .with("table", 10, fcb)
          end
        end

        context "when upsert is true" do
          let(:upsert) { true }

          it "calls get_new_bulk_loader with the correct params" do
            allow(blfcb).to receive(:new).with(any_args).and_return(fcb)

            subject.get_new_bulk_loader("table", 10, upsert, failure)

            expect(java_client)
              .to have_received(:get_new_bulk_loader)
              .with("table", 10, upsert, fcb)
          end
        end
      end

      context "when using both failed and success callbacks" do
        context "when upsert is false used" do
          it "calls get_new_bulk_loader with the correct params" do
            allow(blfcb).to receive(:new).with(any_args).and_return(fcb)
            allow(blscb).to receive(:new).with(any_args).and_return(scb)

            subject.get_new_bulk_loader("table", 10, upsert, failure, success)

            expect(java_client)
              .to have_received(:get_new_bulk_loader)
              .with("table", 10, upsert, fcb, scb)
          end
        end

        context "when upsert is true" do
          let(:upsert) { true }

          it "calls get_new_bulk_loader with the correct params" do
            allow(blfcb).to receive(:new).with(any_args).and_return(fcb)
            allow(blscb).to receive(:new).with(any_args).and_return(scb)

            subject.get_new_bulk_loader("table", 10, upsert, failure, success)

            expect(java_client)
              .to have_received(:get_new_bulk_loader)
              .with("table", 10, upsert, fcb, scb)
          end
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
