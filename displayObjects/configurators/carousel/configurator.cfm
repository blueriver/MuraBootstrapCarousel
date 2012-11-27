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
		params.imageSize='Medium';
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
		
 	<div class="fieldset-wrap row-fluid">
		<div class="fieldset">
		<div class="control-group">
			<div class="span12">
				<label class="control-label">Local Index</label>
				<div class="controls"><select name="feedID" class="objectParam" data-required="true" data-message="Please select a local index.">
					<option value="">-- Select Local index --</option>
					<cfloop query="rsFeeds">
						<option value="#rsFeeds.feedID#"<cfif params.feedID eq rsFeeds.feedID> selected</cfif>>#HTMLEditFormat(rsFeeds.name)#</option>
					</cfloop>
					</select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="span4">
			    <label class="control-label">Image Size</label>
				<div class="controls">
					<select name="imageSize" data-displayobjectparam="imageSize" class="objectParam span10" onchange="if(this.value=='custom'){jQuery('##feedCustomImageOptions').fadeIn('fast')}else{jQuery('##feedCustomImageOptions').hide();jQuery('##feedCustomImageOptions').find(':input').val('AUTO');}">
						<cfloop list="Small,Medium,Large" index="i">
							<option value="#lcase(i)#"<cfif i eq params.imageSize> selected</cfif>>#I#</option>
						</cfloop>
						
						<cfset imageSizes=application.settingsManager.getSite(session.siteid).getCustomImageSizeIterator()>
														
						<cfloop condition="imageSizes.hasNext()">
							<cfset image=imageSizes.next()>
							<option value="#lcase(image.getName())#"<cfif image.getName() eq params.imageSize> selected</cfif>>#HTMLEditFormat(image.getName())#</option>
						</cfloop>
						<option value="custom"<cfif "custom" eq params.imageSize> selected</cfif>>Custom</option>
					</select>
				</div>
			</div>

			<span id="feedCustomImageOptions" class=""<cfif params.imageSize neq "custom"> style="display:none"</cfif>>				
				<div class="span4">
					<label class="control-label">Image Width</label>
					<div class="controls">
						<input class="objectParam span6" name="imageWidth" data-displayobjectparam="imageWidth" type="text" value="#HTMLEditFormat(params.imageWidth)#" />
					</div>
				</div>
					
				<div class="span4">	
					<label class="control-label">Image Height</label>
					<div class="controls">
				      	<input class="objectParam span6" name="imageHeight" data-displayobjectparam="imageHeight" type="text" value="#HTMLEditFormat(params.imageHeight)#" />
				    </div>
				</div>
			</span>
		</div>
			      
		<div class="control-group">
			<div class="span12">
				<label class="control-label">Interval</label>
				<div class="controls">
					<input name="interval" class="objectParam span6" data-required="true" data-validate="numeric" data-message="The interval must be set to a numeric value." value="#HTMLEditFormat(params.interval)#" />
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="span12">
				<label class="control-label">CSS ID</label>
				<div class="controls">
					<input name="cssID" class="objectParam span6" data-required="true" data-message="The CSS ID attribute is required" value="#HTMLEditFormat(params.cssID)#" />
				</div>
			</div>
		</div>

	</div>
	</div>
	</form>			
</div>			
</cfoutput>