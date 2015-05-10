require 'rails_helper'

RSpec.describe Dive, type: :model do
	let(:dive) { FactoryGirl.build :dive }
	subject { dive } 

	it { should validate_presence_of :location }
	it { should validate_presence_of :date }
	it {should validate_presence_of :length }

	it { should belong_to :user }


 end 
