require "spec_helper"

describe OrderMailer do
  describe "order_info" do
    let(:mail) { OrderMailer.order_info }

    it "renders the headers" do
      mail.subject.should eq("Order info")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
