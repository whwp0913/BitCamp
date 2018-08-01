package org.zerock.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.service.MemberService;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private MemberService service;
	
	@Override
	public UserDetails loadUserByUsername(String mid) throws UsernameNotFoundException {
		
		if(service.getUserID(mid) == null) {
			throw new 
			UsernameNotFoundException("no user found with username"+
			service.getUserID(mid).getMid());
		}
		
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
		roles.add(new SimpleGrantedAuthority(service.getUserAuth(mid)));
		UserDetails user = new User(mid, service.getUserID(mid).getMpw(), roles);
		
		return user;
	}
	
	public static String encoder(String password) {
		BCryptPasswordEncoder passencoder = new BCryptPasswordEncoder();
		String encoderPass = passencoder.encode(password);
		return encoderPass;
	}
}
