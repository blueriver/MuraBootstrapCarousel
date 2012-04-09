<!--
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
-->
<cfscript>
	$=application.serviceFactory.getBean("MuraScope").init(session.siteID);
		
	params=$.event("params");
		
	if(isJSON(params)){
		params=deserializeJSON(params);
	} else {
		params=structNew();
	}
		
	if(not structKeyExists(params,"feedID")){
		params.feedID='';
	}

	if(not structKeyExists(params,"imageSize")){
		params.imageSize='Large';
	}

	if(not structKeyExists(params,"imageHeight")){
		params.imageHeight='AUTO';
	}
	if(not structKeyExists(params,"imageWidth")){
		params.imageWidth='AUTO';
	}
	if(not structKeyExists(params,"interval")){
		params.interval=5;
	}

	if(not structKeyExists(params,"cssID")){
        params.cssID="myCarousel";
     }
	
	rsFeeds=$.getBean('feedManager').getFeeds(type='local',siteID=session.siteid);
</cfscript>
<cfoutput>
	<div id="availableObjectParams"
		data-object="plugin" 
		data-name="Example Configured Object" 
		data-objectid="#$.event('objectID')#">
		<form id="availableObjectParamsForm" onsubmit="return false;" style="display:inline;">
		<dl class="singleColumn">
			<dt>Local Index</dt>
			<dd><select name="feedID" class="objectParam" data-required="true" data-message="Please select a local index.">
				<option value="">-- Select Local index --</option>
				<cfloop query="rsFeeds">
					<option value="#rsFeeds.feedID#"<cfif params.feedID eq rsFeeds.feedID> selected</cfif>>#HTMLEditFormat(rsFeeds.name)#</option>
				</cfloop>
			</select></dd>
			<dt class="first">Image Size</dt>
			<dd><select name="imageSize" class="objectParam  dropdown" onchange="if(this.value=='custom'){jQuery('##bsCarouselImageOptions').fadeIn('fast')}else{jQuery('##bsCarouselImageOptions').hide();jQuery('##bsCarouselImageOptions').find(':input').val('AUTO');}">
					<cfloop list="Small,Medium,Large,Custom" index="i">
						<option value="#lcase(i)#"<cfif i eq params.imageSize> selected</cfif>>#I#</option>
					</cfloop>
				</select>
			</dd>

			<dd id="bsCarouselImageOptions"<cfif params.imageSize neq "custom"> style="display:none"</cfif>>
				<dl>
					<dt>Image Width</dt>
					<dd><input name="imageWidth" class="objectParam  text" value="#HTMLEditFormat(params.imageWidth)#" /></dd>
					<dt>Image Height</dt>
					<dd><input name="imageHeight" class="objectParam  text" value="#HTMLEditFormat(params.imageHeight)#" /></dd>
				</dl>
			</dd>
			<dt>Interval</dt>
			<dd><input name="interval" class="objectParam  text" data-required="true" data-validate="numeric" data-message="The interval must be set to a numeric value." value="#HTMLEditFormat(params.interval)#" /></dd>
			<dt>CSS ID</dt>
			<dd><input name="cssID" class="objectParam  text" data-required="true" data-message="The CSS ID attribute is required" value="#HTMLEditFormat(params.cssID)#" /></dd>
		</dl>
		</form>			
	</div>			
</cfoutput>