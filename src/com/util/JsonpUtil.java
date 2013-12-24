package com.util;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class JsonpUtil {
	public static void main(String[] args) throws IOException{
		
		Document doc = Jsoup.connect("http://www.renren.com/").get();
		Elements elements = doc.select("link[rel=shortcut icon]");
		System.out.println(elements.toString());
		
	}
}
