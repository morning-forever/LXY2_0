package com.lx.service.system;

import java.net.UnknownHostException;

import org.java_websocket.WebSocketImpl;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Service;

import com.lx.plugin.websocketInstantMsg.ChatServer;

@Service
public class WebSocketService implements ApplicationListener<ContextRefreshedEvent>{

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
			
		if(event.getApplicationContext().getParent()==null){
			WebSocketImpl.DEBUG = false;
			int port = 8887; //端口
			ChatServer s;
			try {
				s = new ChatServer(port);
				s.start();
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	
	

}
