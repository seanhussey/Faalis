require_dependency "faalis/application_controller"

module Faalis
  class API::V1::ConversationsController < APIController
    before_filter :authenticate_user!
    helper_method :mailbox, :conversation

    def create
      recipient_emails = conversation_params(:recipients).split(',')
      recipients = User.where(email: recipient_emails).all

      @conversation = current_user.
        send_message(recipients, *conversation_params(:body, :subject)).conversation

      respond_with(@conversation)
    end

    def reply
      @conversation = current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
      respond_with(@conversation)
    end

    def trash
      conversation.move_to_trash(current_user)
      redirect_to :conversations
    end

    def untrash
      conversation.untrash(current_user)
      redirect_to :conversations
    end

    def index
      if params[:box] == "inbox"
        box = "inbox"
      elsif params[:box] == "sentbox"
        box = "sentbox"
      elsif params[:box] == "trash"
        box = "trash"
      else
        respond_to do |f|
          f.any { head :not_found }
        end
        return
      end
      # puts current_user.mailbox.sent.to_json
       @mailbox ||= current_user.mailbox.send(box.to_sym)
      respond_with @mailbox
    end


    def show
    #def conversation
      @conversations ||= current_user.mailbox.conversations.find(params[:id])
      @current_user = current_user
      #binding.pry
#      @conversation = {}
#      conversations.each do |conversation|
#        tmp = {
#          :receipts => conversation.receipts,
#          :body => conversation.messages.body,
#          :is_read => conversation.is_read,
#          :trashed => conversation.trashed,
#          :deleted => conversation.deleted,
#          :recipients => conversation.recipients
#        }
        #unless @conversation.include? conversation.id
        #  @conversation[conversation.id] = tmp
        #end
      #end

    end
    private

    def mailbox
      @mailbox ||= current_user.mailbox
    end


    def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
    end

    def conversation_params(*keys)
      #binding.pry
      fetch_params(:conversation, *keys)
    end

    def message_params(*keys)
      fetch_params(:message, *keys)
    end

    def fetch_params(key, *subkeys)
      puts "####################################"
      puts params
      puts key
      puts "####################################"
      puts params[key]
      puts "####################################"
      params[key].instance_eval do
        case subkeys.size
        when 0 then self
        when 1 then self[subkeys.first]
        else subkeys.map{|k| self[k] }
        end
      end
    end
  end
end
