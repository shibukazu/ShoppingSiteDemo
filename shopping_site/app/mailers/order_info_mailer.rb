class OrderInfoMailer < ApplicationMailer
    
    include Roadie::Rails::Automatic
    add_template_helper(ApplicationHelper)

    def send_order_info_to_user(order)
        @user = order.user
        @order = order
        
        mail(
            subject: "ご注文を受け付けました", 
            to: @user.email 
        ) do |format|
            format.text
            format.html
        end
    end
end
