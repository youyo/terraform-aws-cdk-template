from aws_cdk import (
    core,
    aws_lambda as lambda_
)
import os


class Stack(core.Stack):
    def __init__(self, scope: core.Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        foo = os.getenv('FOO')

        f = lambda_.Function(
            self,
            'func',
            code=lambda_.Code.asset('./function/.artifact/'),
            handler='app.handler',
            runtime=lambda_.Runtime.PYTHON_3_7,
            timeout=core.Duration.seconds(30)
        )
        f.add_environment('FOO', foo)

        core.CfnOutput(self, 'functionname', value=f.function_name)


def main():
    app = core.App()
    Stack(app, 'terraform-aws-cdk-template')
    app.synth()


if __name__ == '__main__':
    main()
