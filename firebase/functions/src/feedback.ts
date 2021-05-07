import {Octokit} from "@octokit/rest";
import * as functions from "firebase-functions";
const githubToken = functions.config().github.token;

const octokit = new Octokit({
  auth: githubToken,
});

export const newFeedback = async (link: string, metadata: any) => {
  await octokit.rest.issues.createComment({
    owner: "louis030195",
    repo: "langame-app",
    issue_number: 58,
    body: `
# link
${link}
# metadata
\`\`\`json
${JSON.stringify(metadata, null, 2)}
\`\`\`      
    `,
  });
};

