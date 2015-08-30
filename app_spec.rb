require './interpret_texts'
require 'rspec'


describe 'interpret_tests' do
  let(:text_interpreter) { TextInterpreter.new }
  it "interpret a file directive correctly" do
    file, payload = text_interpreter.interpret_as_file_directive("* Testing - This")
    expect(file).to eq(DROPBOX_LOCATION + "Testing.org")
    expect(payload).to eq("This")
  end

  it "interpret file directives fine with whitespace" do
    file, payload = text_interpreter.interpret_as_file_directive("*Testing-This")
    expect(file).to eq(DROPBOX_LOCATION + "Testing.org")
    expect(payload).to eq("This")
  end

  it "interpret todo correctly" do
    file, payload = text_interpreter.interpret_as_create_org_todo("Testing - 8/25/2015")
    expect(payload).to match(/.*Testing.*SCHEDULED: \<2015-08-25 Tue\>/m)
    expect(file).to match(DROPBOX_NOTE_FILE)
  end

  it "integration tests interpret todo correctly" do
    expect_any_instance_of(TextInterpreter).to receive(:write_payload_to_file).with(DROPBOX_NOTE_FILE, /.*Testing.*SCHEDULED:.*/m)
    text_interpreter.interpret_text("Testing")
  end

  it "integration tests interprets file directive correctly" do
    expect_any_instance_of(TextInterpreter).to receive(:write_payload_to_file).with(DROPBOX_LOCATION + "Testing.org", "Test")
    text_interpreter.interpret_text("* Testing - Test")
  end
end
