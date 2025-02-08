const { releaseChangelog, releasePublish, releaseVersion } = require('nx/release');

async function main() {
  const SHA = "foo";
  const prerelease = true;

  if (prerelease) {
    const { workspaceVersion, projectsVersionData } = await releaseVersion({ dryRun: true, verbose: true });

    console.log({ workspaceVersion, projectsVersionData });
    if (!workspaceVersion) {
      console.log('No new version');
      return;
    }

    const newVersion = workspaceVersion + '-${{ github.ref }}-' + SHA;

    for (const key in projectsVersionData) {
      projectsVersionData[key] = newVersion;
    }

    await releaseVersion({
      dryRun: true,
      specifier: newVersion,
      verbose: true
    });

    await releaseChangelog({
      dryRun: true,
      version: newVersion,
      versionData: projectsVersionData, 
      createRelease: false, 
      verbose: true
    });

    await releasePublish({
      verbose: true,
      tag: '${{ github.ref }}'
    });

    core.setOutput('tag-version', newVersion);
  } else {
    const { workspaceVersion, projectsVersionData } = await releaseVersion({ verbose: true });
    await releaseChangelog({ version: workspaceVersion, versionData: projectsVersionData, verbose: true });
    await releasePublish({ verbose: true });

    core.setOutput('tag-version', workspaceVersion);
  }
}

main().then((result) => {
  console.log(result);
}).catch((err) => {
  console.error(err);
});;