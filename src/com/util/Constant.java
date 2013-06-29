package com.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.htmlparser.NodeFilter;
import org.htmlparser.Parser;
import org.htmlparser.filters.HasAttributeFilter;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.util.NodeList;
import org.htmlparser.util.ParserException;

/**
 * 常量类
 * */
public class Constant {

	public final static String USER = "user";
	
	public final static String BASE = "base";
	
	public final static String LUCENEINDEXPATH = "luceneindexpath";
	
	public final static int BLOGPAGE = 12;
	
	public static void main(String[] args){
		String file = "D:/file/ankang/partime/12099207550601x.html";
		String content = FileHandle.readFile(file);
		try {
			Parser parser = new Parser( content );
		
			
			NodeFilter innerFilter = new TagNameFilter ("h1");
			/** 招聘标题 */
			NodeList nodes = parser.extractAllNodesThatMatch(innerFilter);
			//System.out.println(nodes);
			
			/** 公司信息 */
			parser = new Parser( content );
			NodeFilter filterCompany = new HasAttributeFilter( "class", "companymini" );
			NodeList nodesCompany = parser.extractAllNodesThatMatch(filterCompany);
			String companyContent = nodesCompany.toHtml().replaceAll("\r|\n", "");
			//System.out.println("sjdksds="+companyContent);
			Pattern pattern = Pattern.compile("<p>(.*?)<cite(.*?)公司行业：</span>" +
					"(.*?)<span(.*?)公司性质：</span>(.*?)<span(.*?)公司规模：</span>(.*?)</p>");
			Matcher matcher = pattern.matcher(companyContent);
			while(matcher.find()){
//				System.out.println("sdsds="+matcher.group(1));
//				System.out.println("sdsds="+matcher.group(3));
//				System.out.println("sdsds="+matcher.group(5));
//				System.out.println("sdsds="+matcher.group(7));
			}
			
			/** 职位信息 */
			parser = new Parser( content );
			NodeFilter filterJob = new HasAttributeFilter( "class", "zcon clearfix" );
			NodeList nodesJob = parser.extractAllNodesThatMatch(filterJob);
			String jobContent = nodesJob.toHtml().replaceAll("\r|\n", "");
			//System.out.println("jobContent="+jobContent);
			Pattern patternJob = Pattern.compile("更新时间：</span>(.*?)</li>(.*?)薪资水平：</span>(.*?)</li>" +
					"(.*?)招聘人数：</span>(.*?)</li>(.*?)性别要求：</span>(.*?)</li>(.*?)工作时间：</span>(.*?)</li>");
			Matcher matcherJob = patternJob.matcher(jobContent);
			while(matcherJob.find()){
//				System.out.println("result="+matcherJob.group(1));
//				System.out.println("result="+matcherJob.group(3));
//				System.out.println("result="+matcherJob.group(5));
//				System.out.println("result="+matcherJob.group(7));
//				System.out.println("result="+matcherJob.group(9));
			}
			
			/** 职位描述 */
			parser = new Parser( content );
			NodeFilter filterDesc = new HasAttributeFilter( "id", "zhiwei" );
			NodeList nodesDesc = parser.extractAllNodesThatMatch(filterDesc);
			//System.out.println(nodesDesc.toHtml());
			
			/** 公司介绍 */
			parser = new Parser( content );
			NodeFilter filterIntro = new HasAttributeFilter( "id", "gongsi" );
			NodeList nodesIntro = parser.extractAllNodesThatMatch(filterIntro);
			//System.out.println(nodesIntro.toHtml());
			
			/** 电话 */
			
			parser = new Parser( content );
			NodeFilter filterPhone = new HasAttributeFilter( "id", "showphone" );
			NodeList nodesPhone = parser.extractAllNodesThatMatch(filterPhone);
			//System.out.println(nodesPhone.toHtml());
			
			/** 联系方式 */
			parser = new Parser( content );
			NodeFilter filterLianxi = new HasAttributeFilter( "id", "lianxi" );
			NodeList nodesLianxi = parser.extractAllNodesThatMatch(filterLianxi);
			System.out.println(nodesLianxi.toHtml());
			Pattern patternLianxi = Pattern.compile("系 人：</span>(.*?)</li>(.*?)联系地址：</span>(.*?)</li>");
			Matcher matcherLianxi = patternLianxi.matcher(nodesLianxi.toHtml().replaceAll("\r|\n", ""));
			while(matcherLianxi.find()){
				System.out.println("1="+matcherLianxi.group(1));
				System.out.println("1="+matcherLianxi.group(3));
			}
			
		} catch (ParserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
