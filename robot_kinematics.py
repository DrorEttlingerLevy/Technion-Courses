from manim import *
import numpy as np


class RobotKinematics(ThreeDScene):
    def forward_kinematics(self, theta1, theta2, theta3, l1, l2, l3, l4, l5):
        """
        Computes the end-effector position based on the angles and link lengths.
        """
        x = l3 * np.cos(theta1) * np.cos(theta2) + l4 * np.cos(theta1) * np.cos(
            theta2 + theta3
        )
        y = l3 * np.sin(theta1) * np.cos(theta2) + l4 * np.sin(theta1) * np.cos(
            theta2 + theta3
        )
        z = l1 + l2 + l3 * np.sin(theta2) + l4 * np.sin(theta2 + theta3) + l5
        return np.array([x, y, z])

    def construct(self):
        # Set up 3D camera orientation
        self.set_camera_orientation(phi=75 * DEGREES, theta=30 * DEGREES)

        # Define link lengths
        l1, l2, l3, l4, l5 = 3, 0.88, 4, 0.4, 4.05  # Scaled for visualization

        # Define thetas for three example points
        theta_solutions = [
            [np.pi / 6, np.pi / 4, np.pi / 3],
            [np.pi / 4, np.pi / 6, np.pi / 3],
            [np.pi / 3, np.pi / 4, np.pi / 6],
        ]

        # Base position
        base = Dot3D([0, 0, 0], color=BLUE)
        self.add(base)

        # Animate the robot's motion through the given points
        for thetas in theta_solutions:
            theta1, theta2, theta3 = thetas

            # Calculate joint positions
            joint1 = np.array([0, 0, l1])
            joint2 = joint1 + np.array([l2 * np.cos(theta1), l2 * np.sin(theta1), 0])
            joint3 = joint2 + np.array(
                [
                    l3 * np.cos(theta1) * np.cos(theta2),
                    l3 * np.sin(theta1) * np.cos(theta2),
                    l3 * np.sin(theta2),
                ]
            )
            end_effector = joint3 + np.array(
                [
                    l4 * np.cos(theta1) * np.cos(theta2 + theta3),
                    l4 * np.sin(theta1) * np.cos(theta2 + theta3),
                    l4 * np.sin(theta2 + theta3) + l5,
                ]
            )

            # Create points for joints
            joints = [
                Dot3D(joint1, color=RED),
                Dot3D(joint2, color=GREEN),
                Dot3D(joint3, color=YELLOW),
                Dot3D(end_effector, color=PURPLE),
            ]

            # Create links
            links = [
                Line3D([0, 0, 0], joint1, color=WHITE),
                Line3D(joint1, joint2, color=WHITE),
                Line3D(joint2, joint3, color=WHITE),
                Line3D(joint3, end_effector, color=WHITE),
            ]

            # Add joints and links to the scene
            self.play(
                *[Create(link) for link in links], *[Create(joint) for joint in joints]
            )

            # Pause for visualization
            self.wait(1)

            # Remove joints and links for next configuration
            self.play(
                *[FadeOut(link) for link in links],
                *[FadeOut(joint) for joint in joints],
            )

        self.wait(2)
