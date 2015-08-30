require 'chronic'

DROPBOX_LOCATION = "/home/steggy/Dropbox/national/"
DROPBOX_NOTE_FILE = "#{DROPBOX_LOCATION}dropbox-notes.org"
class TextInterpreter
  def interpret_text(text)
    file, payload = if text.match(/^\*/)
                      interpret_as_file_directive(text)
                    else
                      interpret_as_create_org_todo(text)
                    end
    write_payload_to_file(file, payload)
  end

  def interpret_as_file_directive(text)
    file_name, payload = text.match(/\*([^-]+)\s*-\s*(.*)/).captures.map(&:strip)
    file_name = file_name + ".org" unless file_name =~ /.*\..*/
    ["#{DROPBOX_LOCATION}#{file_name}", payload]
  end

  def interpret_as_create_org_todo(text)
    text, date = text.split("-")
    date = date ? Chronic.parse(date) : Time.now
    formatted_date = date.strftime("%Y-%m-%d %a")
    full_payload = "
* TODO #{text}
SCHEDULED: <#{formatted_date}>"
    [DROPBOX_NOTE_FILE, full_payload]
  end

  def write_payload_to_file(file, payload)
    File.open(file, 'a+') { |f| f.write(payload)}
  end
end
