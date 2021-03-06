require 'spec_helper'

describe Clearbit::Slack::Notifier do
  let(:notifier) { double(ping: true) }

  before do
    allow(Slack::Notifier).to receive(:new).and_return(notifier)
  end

  context 'default values for given_name and family_name' do
    it 'returns the default values' do
      params = {
        person: nil,
        given_name: 'Alex',
        family_name: 'Maccaw',
        email: 'alex@alexmaccaw.com',
        message: 'message'
      }

      Clearbit::Slack::Notifier.new(params).ping

      expect(Slack::Notifier).to have_received(:new).with(
        'http://example', {
          channel: '#test',
          icon_url: nil,
        }
      )

      expect(notifier).to have_received(:ping).with('message', attachments: [{
        :author_name=>nil,
        :author_icon=>nil,
        :text=>nil,
        :color=>"good",
        fields: [{
          title: 'Email',
          value: 'alex@alexmaccaw.com',
          short: true
        }]
      }])
    end
  end
end
