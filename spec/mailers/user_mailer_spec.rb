require "spec_helper"

describe UserMailer do
  let(:user) { create(:user) }

  describe "activation_needed_email" do
    let(:mail) { UserMailer.activation_needed_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to Tidal")
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(["info@tidal.io"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to have_content(user.activation_token)
    end
  end

  describe "activation_success_email" do
    let(:mail) { UserMailer.activation_success_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Your Tidal account is now activated")
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(["info@tidal.io"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to have_content("You have successfully activated your tidal.io account")
    end
  end

end
