/*
	Copyright 2012 Blue River Interactive

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/
component extends="mura.plugin.pluginGenericEventHandler" {

	public any function dspCarousel($) {
		var params=$.event('objectParams');
		var str='';
		var slides='';
		var slide='';
		var class='';
		var style='';

		defaultParams = {
			feedID=''
			,imageSize='Large'
			,imageHeight='AUTO'
			,imageWidth='AUTO'
			,interval=5
			,cssID='myCarousel'
		};

		StructAppend(params, defaultParams, false);

		if (len(params.feedID)) {
			slides=$.getBean("feed").loadBy(feedID=params.feedID).getIterator();

			if (slides.hasNext()) {
				$.loadJSLib();

				str='<div id="#htmlEditFormat(params.cssID)#" class="carousel slide"><div class="carousel-inner">';

				class='item active';

				while(slides.hasNext()){
					slide=slides.next();
					if ( ListFindNoCase('jpg,jpeg,gif,png', ListLast(slide.getImageURL(), '.')) ) {
						str=str & '<div class="#class#">
							<img src="#slide.getImageURL(size=params.imagesize,height=params.imageHeight,width=params.imageWidth)#" alt="#HTMLEditFormat(slide.getTitle())#">
							<div class="carousel-caption">
								<h4><a href="#slide.getURL()#">#HTMLEditFormat(slide.getTitle())#</a></h4>
								#slide.getSummary()#
							</div>
						</div>';
						class='item';
					}
				}
				str=str & '</div><a class="left carousel-control" href="###htmlEditFormat(params.cssID)#" data-slide="prev">&lsaquo;</a><a class="right carousel-control" href="###htmlEditFormat(params.cssID)#" data-slide="next">&rsaquo;</a></div><script>$("document").ready(function(){$("###params.cssID#").carousel({interval: #evaluate(params.interval * 1000)#});});</script>';
				pluginConfig.addToHtmlFootQueue('displayObjects/htmlfoot/htmlfoot.cfm');

			}
		}
		return str;
	}
}
