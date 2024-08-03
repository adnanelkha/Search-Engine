-- SearchEngineModule v2 by bv_hl

local SearchEngineModule = {}
SearchEngineModule.__index = SearchEngineModule

export type SearchParams = {
	Catalog: ScrollingFrame, 
	SearchBox: TextBox,

	CurrentSearchString: string,
}

-- Utility function to filter catalog items based on search string
local function filterCatalogItems(catalog: ScrollingFrame, searchString: string)
	for _, item in ipairs(catalog:GetChildren()) do
		if item:IsA("TextButton") then
			if string.find(string.lower(item.Name), string.lower(searchString)) then
				item.Visible = true
			else
				item.Visible = false
			end
		end
	end
end

function SearchEngineModule.new(ScrollingFrame: ScrollingFrame, TextBox: TextBox): SearchParams
	local self = setmetatable({}, SearchEngineModule)
	self.Catalog = ScrollingFrame
	self.SearchBox = TextBox
	self.CurrentSearchString = ""

	-- Connect the search box text change signal to update the catalog
	TextBox:GetPropertyChangedSignal("Text"):Connect(function() 
		self.CurrentSearchString = TextBox.Text
		filterCatalogItems(self.Catalog, self.CurrentSearchString)
	end)

	return self
end

return SearchEngineModule
