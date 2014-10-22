class User < ActiveRecord::Base
	def self.from_omniauth(auth)
    	where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	      user.provider = auth.provider
	      user.uid = auth.uid
	      user.name = auth.info.name
	      user.oauth_token = auth.credentials.token
	      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	      user.save!
   		end
  	end

  	def facebook
  		@facebook ||= Koala::Facebook::API.new(oauth_token)
      block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
      logger.info e.to_s
      nil
    end 

  	

  	 def myCheckIns
  	  
        
        places = []

        page = facebook.get_connections('me', 'tagged_places')
        begin
        places += page.map {|p| p['place']}
        end while page = page.next_page
         
        places.each do |place|
        unless place['location'].is_a? String
        puts "#{place['name']} lat:#{place['location']['latitude']} long:#{place['location']['longitude']}"
        else
        puts "#{place['name']} location:#{place['location']}"
        end
        end
     end

     def friendsCheckiIns
      facebook.get_connections("me","friends", :fields => "tagged_places")
     end

   end 
    
  