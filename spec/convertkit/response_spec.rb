require "spec_helper"

module Convertkit
  describe Response do
    describe "#success?" do
      context "status is in 200..209 range" do
        it "returns true" do
          (200..209).each do |status|
            subject = Convertkit::Response.new(status, {})
            expect(subject.success?).to be_truthy
          end
        end
      end
      
      context "status is 404 or 415 or 500" do
        it "returns false if 404" do
          subject = Convertkit::Response.new(404, {})
          expect(subject.success?).to be_falsey
        end
        
        it "returns false if 415" do
          subject = Convertkit::Response.new(415, {})
          expect(subject.success?).to be_falsey
        end
        
        it "returns false if 500" do
          subject = Convertkit::Response.new(500, {})
          expect(subject.success?).to be_falsey
        end
      end
    end
    
    describe "#==" do
      context "body and status are equal" do
        it "returns true" do
          status = 200
          body = { subscribers: [{email: "jane@domain.com", first_name: "Jane"}]}
          
          subject_one = Convertkit::Response.new(status, body.clone)
          subject_two = Convertkit::Response.new(status, body.clone)
          
          expect(subject_one).to eq(subject_two)
        end
      end
    end
    
    describe "#links" do
      context "links are present" do
        before do
          @links = { subscribers: { email: "janedoe@domain.com", first_name: "Jane" } }
          @body = { links: @links }
          @subject = Convertkit::Response.new(200, @body)
        end
        
        it "returns links object" do
          expect(@subject.links).to eq(@links)
        end
      end
      
      context "links are not present" do
        before do
          @body = {}
          @subject = Convertkit::Response.new(200, @body)
        end
        
        it "returns nil" do
          expect(@subject.links).to eq(nil)
        end
      end
      
      context "body is empty" do
        before do
          @body = ""
          @subject = Convertkit::Response.new(200, @body)
        end
        
        it "returns nil" do
          expect(@subject.links).to eq(nil)
        end
      end
    end
    
    describe "#meta" do
      context "meta is present" do
          before do
            @meta = { page: 1 }
            @body = { meta: @meta }
            @subject = Convertkit::Response.new(200, @body)
          end
        
        it "returns meta object" do
          expect(@subject.meta).to equal(@meta)
        end
      end
      
      context "meta is not present" do
        before do
          @body = {}
          @subject = Convertkit::Response.new(200, @body)
        end
        
        it "returns nil" do
          expect(@subject.meta).to eq(nil)
        end
      end
      
      context "body is empty" do
        before do
          @body = ""
          @subject = Convertkit::Response.new(200, @body)
        end
        it "returns nil" do
          expect(@subject.meta).to eq(nil)
        end
      end
    end
  end
end