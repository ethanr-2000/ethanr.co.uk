const { releaseChangelog, releasePublish, releaseVersion } = require('nx/release');

const core = {
  setOutput: (name, value) => {
    console.log(`::set-output name=${name}::${value}`);
  }
}

async function main() {
  const SHA = "foo";
  const prerelease = true;

  if (prerelease) {
    console.log('Creating pre-release');

    const { workspaceVersion, projectsVersionData } = await releaseVersion({ dryRun: true, verbose: true });

    console.log({ workspaceVersion, projectsVersionData });
    if (!workspaceVersion) {
      console.log('No new version');
      return;
    }

    const prereleaseVersion = workspaceVersion + '-' + SHA;

    for (const key in projectsVersionData) {
      projectsVersionData[key] = prereleaseVersion;
    }

    await releaseVersion({
      dryRun: true,
      specifier: prereleaseVersion,
      verbose: true
    });

    await releaseChangelog({
      dryRun: true,
      version: prereleaseVersion,
      versionData: projectsVersionData, 
      createRelease: false, 
      verbose: true
    });

    await releasePublish({
      verbose: true,
      tag: "refs/pull/8/merge",
    });

    core.setOutput('tag-version', prereleaseVersion);
    process.exit(0);
  } else {
    const { workspaceVersion, projectsVersionData } = await releaseVersion({ verbose: true });
    await releaseChangelog({ version: workspaceVersion, versionData: projectsVersionData, verbose: true });
    await releasePublish({ verbose: true });

    core.setOutput('tag-version', workspaceVersion);
    process.exit(0);
  }
}

main().then(() => {}).catch((err) => {
  console.error(err);
});;