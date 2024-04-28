param(
    [string]$inputFile, 
    [string]$outputDirectory
)

# Read the content from the source Markdown file
$content = Get-Content $inputFile -Raw

# Extract the date from the filename and prepare the header
$filename = [System.IO.Path]::GetFileNameWithoutExtension($inputFile)
$dateHeader = "# " + $filename.Replace("-", "/") + "`n`n"

# Initialize the output content with the date header
$outputContent = $dateHeader

# Split the content into sections based on headers
$sections = $content -split '(?m)^## '

foreach ($section in $sections) {
    # Check if the section has any non-header content
    if ($section -match "\n") {
        # Re-add the '## ' prefix to the section header
        $outputContent += "## " + $section + "`n"
    }
}

# Remove trailing newlines from the output content
$outputContent = $outputContent.TrimEnd("`n")

# Write the output content to a new file in the output directory
$outputFile = Join-Path $outputDirectory $filename + ".md"
$outputContent | Out-File $outputFile -Encoding utf8

Write-Host "Converted file saved to $outputFile"